#import "preprocessing.typ": *
#import "board.typ": *
#import "clues.typ": *


// Produce a single-page crossword.
//
// Parameters:
// - `data`: the data loaded from the crossword's TOML file. See `preprocessing.typ`.
// - `show_solution`: if `true`, show the solution to the crossword.
// - `show_cell_coordinates`: if `true` (and `show_solution` is also `true`), display the
//   coordinates of the cells below the letters. This is useful when debugging or placing clues.
// - `cell_size`: the size of the cells of the board.
// - `letter_size`: the size of the letter of each cell.
// - `number_size`: the size of the number of each cell (if any).
// - `margin`: the page margin.
// - `clue_columns`: the number of columns to split the clues into.
#let single_page(
    data,
    show_solution: false,
    show_cell_coordinates: false,
    cell_size: 25pt,
    letter_size: 8pt,
    number_size: 5pt,
    margin: 1cm,
    clue_columns: 2,
) = {
    set text(size: letter_size)
    set page(paper: "presentation-16-9", margin: margin)

    block(width: 100%, height: 100%)[
        #set align(center)
        = #data.title \
        #emph[by #data.author]

        #set align(center + horizon)

        #grid(
            columns: (auto, auto),
            gutter: 20pt,
            block(height: auto, width: 100%)[
                #set align(center + horizon)
                #board(
                    data,
                    show_solution: show_solution,
                    show_cell_coordinates: show_cell_coordinates,
                    cell_size: cell_size,
                    letter_size: letter_size,
                    number_size: number_size,
                )
            ],
            block(height: auto, width: 100%)[
                #columns(clue_columns)[
                    #set align(left)

                    == Across
                    #clues_across(data)

                    == Down
                    #clues_down(data)
                ]
            ]
        )
    ]
}
