loadRawData <- function(temp) {
					
					# Get EVI-Pro charge session data -------------------------------------------------------
					evi_raw_sedan <- readRDS(paste0("input/preprocessed/evi_raw_sedan/", temp, ".rds"))
					# add column for vehicle class
					evi_raw_sedan[, "class_type" := "Sedan"]
					
					# Repeat for SUVs
					evi_raw_suv <- readRDS(paste0("input/preprocessed/evi_raw_suv/", temp, ".rds"))
					
					# add column for vehicle class
					evi_raw_suv[, "class_type" := "SUV"]
					
					# add one hundred million to the unique vids to distinguish from sedan data
					evi_raw_suv[, unique_vid := unique_vid + 100000000]
				
					# Bind sedan and suv data into a list
					evi_raw_dt <- rbindlist(list(evi_raw_sedan, evi_raw_suv))
					
					#Factor class_type
					evi_raw_dt$class_type <- factor(evi_raw_dt$class_type,levels=c("Sedan","SUV"))
				
					#	Garbage collection
					gc(rm(evi_raw_suv, evi_raw_sedan))
					
					# Get pre-calculated load profiles --------------------------------------------------------
					evi_load_profiles <- readRDS(paste0("input/preprocessed/load_profile_sedan/", temp, ".rds"))

					# add vehicle class
					evi_load_profiles[, "class_type" := "Sedan"]

					# Repeat for SUVs
					evi_load_profiles_suv <- readRDS(paste0("input/preprocessed/load_profile_suv/", temp, ".rds"))

					# add vehicle class
					evi_load_profiles_suv[, "class_type" := "SUV"]

					# add one hundred million to unique vid to distinguish SUV class of vehicle
					evi_load_profiles_suv[, unique_vid := unique_vid + 100000000]

					# Bind sedan and suv data into a list
					evi_load_profiles_dt <- rbindlist(list(evi_load_profiles, evi_load_profiles_suv))
					
					#Factor class_type
					evi_load_profiles_dt$class_type <- factor(evi_load_profiles_dt$class_type,levels=c("Sedan","SUV"))
					
					#Garbage collection
				  gc(rm(evi_load_profiles, evi_load_profiles_suv))

				  # Return loaded data ----------------------------------------------------------------------
					return(list(evi_raw_dt, evi_load_profiles_dt))
}
