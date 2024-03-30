#import "@local/cross:0.0.1" as cross

#let crossword_data = toml("data.toml")

#cross.single_page(
    crossword_data,
    show_solution: false, 
    show_cell_coordinates: false,
    cell_size: 23pt,
    letter_size: 7pt,
    number_size: 5pt,
    margin: 0.2cm,
    clue_columns: 3,
)
