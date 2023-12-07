## 2 - Meaning of life - The data.

# Create a data frame referencing the data visualization
life_meaning <- data.frame(
  country = c("Australia", "New Zealand", "Sweden", "France", "Greece", 
              "Germany", "Canada", "Singapore", "Italy", "Netherlands", 
              "Belgium", "Japan", "UK", "U.S.", "Spain", "South Korea", 
              "Taiwan"),
  First_Choice = c("Family", "Family", "Family", "Family", "Family", 
                   "Family", "Family", "Family", "Family", 
                   "Family", "Family", "Family", "Family", "Family", 
                   "Health", "Material well-being", "Society"),
  Second_Choice = c("Occupation", "Occupation", "Occupation", "Occupation", 
                    "Occupation", "Occupation", "Occupation", 
                    "Occupation", "Occupation", "Material well-being", 
                    "Material well-being", "Material well-being", "Friends", 
                    "Friends", "Material well-being", "Health", 
                    "Material well-being"),
  Third_Choice = c("Friends", "Friends", "Friends", "Health", "Health", 
                   "Health", "Material well-being", "Society", 
                   "Material well-being", "Health", "Occupation", 
                   "Occupation", "Hobbies", "Hobbies", "Occupation", 
                   "Family", "Family"),
  Fourth_Choice = c("Material well-being", "Material well-being", 
                    "Material well-being", "Material well-being", 
                    "Friends", "Material well-being", 
                    "Friends", "Material well-being", "Health", "Friends", 
                    "Health", "Health", "Occupation", "Occupation", 
                    "Family", "General Positive", "Freedom"),
  Fifth_Choice = c("Society", "Society", "Health", 
                   "Friends", "Hobbies", "General Positive", 
                   "Society", "Friends", "Friends", "Occupation", "Friends", 
                   "Hobbies", "Health", "Faith", "Society", "Society", 
                   "Hobbies")
)

# Save the data frame to a CSV file using the write.csv command
write.csv(life_meaning, file = "data/life_meaning.csv", row.names = FALSE)
