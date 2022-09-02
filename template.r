library(data.table)
source("src/tidy_grey.R")


theme_set(theme_custom(12))

base <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/"
dates <- "2022/2022-01-11/"
filenames <- c("colony.csv", "stressor.csv")
output <- "output.pdf"

url <- paste0(base, dates, filenames)
dfs <- list(length(filenames))
for (i in 1:length(filenames)) {
  dfs[[i]] <- fread(url[i])
}

# Wrangle data
df <- dfs[[1]]
stressor <- dfs[[2]]

theme_update(
    line = element_blank(),
    rect = element_rect(fill = "#8d7623", color = "transparent"),
    panel.border = element_blank(),
    axis.text = element_blank(),
    plot.title = element_text(color = "#1c1600", hjust = 0, size = 30, margin = margin(0, 0, 0, 0)),
    plot.subtitle = element_text(
      color = "grey30",
      hjust = 0,
      size = 12,
      margin = margin(0, 0, 0, 0)
    ),
    plot.caption = element_text(color = "grey30", size = 8)
)

ggplot(aes(x = months, y = colony_n, color = months), data = df) +
  labs(title = "Test", subtitle = "Test", x = "Months", y = "Number of bees") +
  geom_boxplot()

ggsave(output, width = 12, height = 20, device = cairo_pdf)
