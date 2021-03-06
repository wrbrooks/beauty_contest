# pairwise comparison of PRESS for leave-one-year-out CV
keys = levels(press.meanranks.annual$method)
press.pairs.annual = matrix(NA, length(keys)-1, length(keys)-1)
press.table.annual = press.meanranks.annual %>% 
    dcast(rep~method, fun.aggregate=mean, value.var='meanrank') 

for (i in 1:(length(keys)-1)) {
    for (j in (i+1):length(keys)) {
        press.pairs.annual[i,j-1] =
            press.table.annual %>% 
            apply(1, function(x) x[keys[i]] > x[keys[j]]) %>% 
            mean
    }
}
colnames(press.pairs.annual) = keys[2:length(keys)]
rownames(press.pairs.annual) = keys[1:(length(keys)-1)]
