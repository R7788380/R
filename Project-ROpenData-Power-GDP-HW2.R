power.df2 %<>% mutate(id2 = translation.power[id])
power.df3 <- power.df2[complete.cases(power.df2$id2),] %>%
    group_by(year,id2) %>%
    summarise(power = sum(power),name = paste(name,collapse = ","))

gdp.df2 %<>% mutate(id2 = translation.gdp[id])
gdp.df3 %<>% group_by(year,id2) %>%
    summarise(gdp = sum(gdp))

power.gdp <- inner_join(power.df3,gdp.df3,by = c("year","id2")) %>%
    mutate(eff = gdp/power) %>%
    as.data.frame()