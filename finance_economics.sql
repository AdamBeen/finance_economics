--Quelle est la performance moyenne de chaque indice boursier sur la période ?
SELECT 
    stock_index,
    ROUND(AVG(ret_close_pct), 4) AS avg_daily_return,
    ROUND(MIN(ret_close_pct), 4) AS worst_day,
    ROUND(MAX(ret_close_pct), 4) AS best_day,
    COUNT(*) AS total_days
FROM market_daily_enriched
WHERE ret_close_pct IS NOT NULL
GROUP BY stock_index
ORDER BY avg_daily_return DESC;


--Quelle est la volatilité moyenne (30 jours) de chaque indice boursier ?
SELECT 
    stock_index,
    ROUND(AVG(vol_30d), 4) AS avg_volatility_30d,
    ROUND(MIN(vol_30d), 4) AS min_volatility,
    ROUND(MAX(vol_30d), 4) AS max_volatility,
    COUNT(*) AS total_days
FROM market_daily_enriched
WHERE vol_30d IS NOT NULL
GROUP BY stock_index
ORDER BY avg_volatility_30d DESC;


--Quel est le ratio rendement / volatilité (30 jours) moyen de chaque indice boursier ?
SELECT 
    stock_index,
    ROUND(AVG(ret_close_pct), 4) AS avg_return,
    ROUND(AVG(vol_30d), 4) AS avg_volatility_30d,
    ROUND(AVG(ret_close_pct) / NULLIF(AVG(vol_30d), 0), 4) AS return_volatility_ratio
FROM market_daily_enriched
WHERE ret_close_pct IS NOT NULL
  AND vol_30d IS NOT NULL
GROUP BY stock_index
ORDER BY return_volatility_ratio DESC;


--Quelle est l'évolution du rendement moyen par année (et par indice) ?
SELECT
    year,
    stock_index,
    ROUND(AVG(ret_close_pct), 4) AS avg_daily_return,
    COUNT(*) AS total_days
FROM market_daily_enriched
WHERE ret_close_pct IS NOT NULL
  AND year IS NOT NULL
GROUP BY year, stock_index
ORDER BY year, avg_daily_return DESC;


--Quelles sont les années les plus volatiles (volatilité moyenne 30 jours) ?
SELECT
    year,
    ROUND(AVG(vol_30d), 4) AS avg_volatility_30d,
    ROUND(MIN(vol_30d), 4) AS min_vol_30d,
    ROUND(MAX(vol_30d), 4) AS max_vol_30d,
    COUNT(*) AS total_days
FROM market_daily_enriched
WHERE vol_30d IS NOT NULL AND year IS NOT NULL
GROUP BY year
ORDER BY avg_volatility_30d DESC;


--Y a-t-il une corrélation entre la croissance du PIB et les rendements (global et par indice) ?
SELECT
    COALESCE(stock_index, 'ALL_INDICES') AS stock_index,
    ROUND(CAST(CORR(gdp_growth_pct, ret_close_pct) AS numeric), 4) AS corr_gdp_ret,
    COUNT(*) AS n_obs
FROM market_daily_enriched
WHERE gdp_growth_pct IS NOT NULL AND ret_close_pct IS NOT NULL
GROUP BY ROLLUP (stock_index)
ORDER BY stock_index NULLS LAST;


--L’inflation a-t-elle un impact sur les rendements (corrélation global + par indice) ?
SELECT
    COALESCE(stock_index, 'ALL_INDICES') AS stock_index,
    ROUND(CAST(CORR(inflation_rate_pct, ret_close_pct) AS numeric), 4) AS corr_inflation_ret,
    COUNT(*) AS n_obs
FROM market_daily_enriched
WHERE inflation_rate_pct IS NOT NULL AND ret_close_pct IS NOT NULL
GROUP BY ROLLUP (stock_index)
ORDER BY stock_index NULLS LAST;

--Quels indices affichent les volumes de trading moyens les plus élevés ?
SELECT
    stock_index,
    ROUND(AVG(trading_volume), 0) AS avg_trading_volume,
    ROUND(MIN(trading_volume), 0) AS min_volume,
    ROUND(MAX(trading_volume), 0) AS max_volume,
    COUNT(*) AS total_days
FROM market_daily_enriched
WHERE trading_volume IS NOT NULL
GROUP BY stock_index
ORDER BY avg_trading_volume DESC;


--Quelles périodes du calendrier sont les plus actives (volume et volatilité moyens par mois) ?
SELECT
    month,
    ROUND(AVG(trading_volume), 0) AS avg_trading_volume,
    ROUND(AVG(vol_30d), 4)       AS avg_volatility_30d,
    COUNT(*) AS total_days
FROM market_daily_enriched
WHERE month IS NOT NULL
GROUP BY month
ORDER BY avg_trading_volume DESC;


--Comment évoluent rendements et volatilité selon le niveau de chômage (par tranches) ?
WITH buckets AS (
  SELECT
    CASE
      WHEN unemployment_rate_pct < 4 THEN '[0,4)'
      WHEN unemployment_rate_pct < 6 THEN '[4,6)'
      WHEN unemployment_rate_pct < 8 THEN '[6,8)'
      WHEN unemployment_rate_pct < 10 THEN '[8,10)'
      ELSE '[10,+Inf)'
    END AS unemployment_band,
    ret_close_pct,
    vol_30d
  FROM market_daily_enriched
  WHERE unemployment_rate_pct IS NOT NULL
)
SELECT
  unemployment_band,
  ROUND(AVG(ret_close_pct), 4) AS avg_return,
  ROUND(AVG(vol_30d), 4)      AS avg_volatility_30d,
  COUNT(*) AS n_obs
FROM buckets
GROUP BY unemployment_band
ORDER BY unemployment_band;






