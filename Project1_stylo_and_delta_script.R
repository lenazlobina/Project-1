library(stylo)
stylo()

## загружаем и делим на слова тексты, считаем относительную частотность
my_corpus <- load.corpus.and.parse(files = c("author_texts.txt", "penname_texts.txt", 
                                             "colleague_texts.txt"), corpus.dir = getwd(), 
                                   markup.type= "plain", corpus.lang = "Other", 
                                   sampling = "no.sampling", preserve.case = FALSE, 
                                   encoding = "UTF-8")

## список самых частотных слов
mfw <- make.frequency.list(my_corpus, relative = TRUE, value =FALSE)
mfw <- mfw[1:10]
mfw
## считаем относ. частотность для каждого слова в каждом тексте
freq_all <- as.data.frame.matrix(as.table(make.table.of.frequencies(my_corpus, mfw)))
freq_all

## считаем стандартизированные значения; из каждого значения в столбце вычитается среднее, 
#разница делится на стандартное отклонение
scaled_fr <- scale(freq_all)
scaled_fr

## дистанция Манхэттена измеряет разницу между двумя векторами и суммирует ее абсолютные значения: Σ|ai – bi|
my_dist <- dist(scaled_fr, method = "manhattan") 
my_dist

## разделив эту дистанцию на количество слов, получаем искомое значение Δ
my_delta <- my_dist/10
my_delta

# вычислим классическую дельту
dist.delta(freq_all)
# вычислим дельту Эдера, наиболее эффективную для флективных языков( вт. ч. русского)
dist.eder(freq_all)
# вычислим косинусную дельту, наиболее эффективную для атрибуции авторства 
dist.wurzburg(freq_all)
# во всех трех случаях получилось, что корпус автора ближе к корпусу коллеги, чем к корпусу под псевдонимом :) 
# попробуем увеличить количество обрабатываемых частотных слов до 300 и посмотреть, изменятся ли расстояния

mfw1 <- make.frequency.list(my_corpus, relative = TRUE, value =FALSE)
mfw1 <- mfw1[1:300]
mfw1

freq_all1 <- as.data.frame.matrix(as.table(make.table.of.frequencies(my_corpus, mfw1)))
freq_all1

dist.delta(freq_all1)

dist.eder(freq_all1)

dist.wurzburg(freq_all1)
# Ура, расстояния соответствуют действительности, значит, для атрибуции авторства при помощи R и stylo()
# важно для объмных корпусов использовать от 100 и более частотных слов 

