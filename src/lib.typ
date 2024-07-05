#import "preprocessing.typ": *
#import "board.typ": *
#import "clues.typ": *


// Produce a single-page crossword.
//
// Parameters:
// - `data`: the data loaded from the crossword's TOML file. See `preprocessing.typ`.
// - `show-solution`: if `true`, show the solution to the crossword.
// - `show-cell-coordinates`: if `true` (and `show-solution` is also `true`), display the
//   coordinates of the cells below the letters. This is useful when debugging or placing clues.
// - `cell-size`: the size of the cells of the board.
// - `letter-size`: the size of the letter of each cell.
// - `number-size`: the size of the number of each cell (if any).
// - `margin`: the page margin.
// - `clue-columns`: the number of columns to split the clues into.
#let single-page(
    data,
    show-solution: false,
    show-cell-coordinates: false,
    cell-size: 25pt,
    letter-size: 8pt,
    number-size: 5pt,
    margin: 1cm,
    clue-columns: 2,
) = {
    set text(size: letter-size)
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
                    show-solution: show-solution,
                    show-cell-coordinates: show-cell-coordinates,
                    cell-size: cell-size,
                    letter-size: letter-size,
                    number-size: number-size,
                )
            ],
            block(height: auto, width: 100%)[
                #columns(clue-columns)[
                    #set align(left)

                    == Across
                    #clues-across(data)

                    == Down
                    #clues-down(data)
                ]
            ]
        )
    ]
}
