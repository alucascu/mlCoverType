library(npsm)
library(class)

data <- read.csv(gzfile("covtype.data.gz"), head = FALSE)
names <- read.csv("terms.csv")

soil_names <- read.csv("soil_codes.csv", head = FALSE)
colnames(soil_names) <- c("study_name", "ELU_code", "Description")
soil_descrip <- data.frame(
						    soil_study_desig = c(rep("n/a", 15,), soil_names$study_name),
							ELU_code = c(rep("n/a", 15), soil_names$ELU_code),
							soil_descrip = c(rep("n/a", 15), soil_names$Description)
							)

wilderness_descrip <- data.frame(
								wild_area_study_desig = c(rep("n/a", 10), seq(1,4), rep("n/a", 41)),
								locatation = c(rep("n/a", 10), "Rawah Wilderness Area", "Neota Wilderness Area", "Comanche Peak Wilderness Area", "Cache la Poudre Wilderness Area", rep("n/a", 41))
								)
cover_type_vec <- c("Spruce/Fir", "Lodgepole Pine", "Ponderosa Pine","Cottonwood/Willow",  "Aspen", "Douglas-fir",
"Krummholz")



g <- sample(c(rep(1, 1+ 2 * dim(data)[1]/ 3), rep(2, dim(data)[1] / 3)))


dim(data)
table(g)

rd_train <- data[g==1,]
rd_test <- data[g==2,]

rd_cv <- knn_cv(rd_train, kvec = seq(1,21))

round(rd_cv$error, 4)
rd_cv$best
