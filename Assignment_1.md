#Assignment 1 

##Dataset
The dataset used for analysis was extracted from Huihben et al. (2018). This paper study evaluated the rate of evolution of the _Plasmodium chabaudi_ malaria parasite in relation to competition with susceptible parasites. Their goal was to investigate the fitness of drug-resistant pathogens in the presence of susceptible pathogens and how competitive suppression and release affect antibiotic resistance. They found that competition with susceptible parasites significantly decreased the fitness of resistant parasites (Huihben et al., 2018).

This dataset consisted of two experiments, each studying its own goal. Mice in experiment 2 were assigned to 13 conditions that differed in genotype, infection status, pathogen density, susceptible pathogen density, and drug dose. Fitness was measured by red blood cell density and body weight. These were chosen as they represent the main symptoms of malaria: anemia and weight loss. 

##Goal
The biological question this dataset intends to investigate is how the different parasite densities affect host health (weight and RBCs). I am investigating whether the exploitation competition for a limited resource (red blood cells) leads to greater environmental degradation (host health decline) than single-species exploitation. In other words, how competition affects whether it increases damage to the host, since it is a "mixed" infection where two strains are fighting for resources, causes more damage to the mouse's blood than a single-strain infection would. The asexual population of both pathogens will be analyzed, as this stage is responsible for host infection, while the gametic stage is responsible for transmission. 

A Competition Index will be calculated for mixed-infection groups by comparing the observed red blood cell (RBC) loss against the mean RBC loss in single-strain control groups. Linear regression to determine if the ratio of sensitive-to-resistant parasite density ($S:R$) on the day of peak infection is a significant predictor of the host's minimum RBC count. Moreover, since linear regression is a supervised machine learning model, the dataset can be extended to predict additional outcomes.

For this assignment, the maximum RBC loss for the untreated competition group (Box 12) compared to the untreated control group (Box 4) will be computed. This can then be used for further calculations of the competition index. 

##Dataset Reference
Huijben, S., Chan, B. H., Nelson, W. A., & Read, A. F. (2018). The impact of within-host ecology on the fitness of a drug-resistant parasite. Evolution, Medicine, and Public Health, 2018(1), 127–137. doi:10.1093/emph/eoy016 


