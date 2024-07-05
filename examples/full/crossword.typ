#import "@local/cross:0.0.2" as cross

#let crossword-data = toml("data.toml")

#cross.single-page(
    crossword-data,
    show-solution: false,
    show-cell-coordinates: false,
    cell-size: 23pt,
    letter-size: 7pt,
    number-size: 5pt,
    margin: 0.2cm,
    clue-columns: 3,
)
