#import "preprocessing.typ": *


// Produce a white cell of the crossword's board.
//
// Parameters:
// - `letter`: the letter to place in the cell.
// - `number`: the number to display on the top left corner of the cell (if any).
// - `show-letter`: if `true`, show the letter of the cell.
// - `letter-size`: the size of the letter of the cell.
// - `number-size`: the size of the number of the cell (if any).
#let _white-cell(
    letter,
    number: none,
    show-letter: false,
    letter-size: none,
    number-size: none,
) = rect(width: 100%, height: 100%, stroke: 1pt + black)[
    #if show-letter == true {
        align(center + horizon)[
            #text(letter, size: letter-size)
        ]
    }

    #if number != none {
        place(top + left)[
            #text([#number], size: number-size)
        ]
    }
]

// Produce a black cell of the crossword's board.
#let _black-cell() = rect("", width: 100%, height: 100%, fill: black, stroke: 1pt + black)

// Produce the crossword board.
//
// Parameters:
// - `data`: the data loaded from the crossword's TOML file. See `preprocessing.typ`.
// - `show-solution`: if `true`, show the solution to the crossword.
// - `show-cell-coordinates`: if `true` (and `show-solution` is also `true`), display the
//   coordinates of the cells below the letters. This is useful when debugging or placing clues.
// - `cell-size`: the size of the cells of the board.
// - `letter-size`: the size of the letter of each cell.
// - `number-size`: the size of the number of each cell (if any).
#let board(
    data,
    show-solution: false,
    show-cell-coordinates: false,
    cell-size: 30pt,
    letter-size: 11pt,
    number-size: 8pt,
) = {
    let data = _process-data(data)

    grid(
        columns: range(data.width).map(n => cell-size),
        rows: range(data.height).map(n => cell-size),

        ..data.cells.map(cell => {
            if cell.letter == "#" {
                _black-cell()
            } else {
                _white-cell(
                    if show-cell-coordinates {
                        [
                            #strong(cell.letter)
                            #place(bottom + center)[
                                #text(size: number-size)[
                                    #cell.row, #cell.column
                                ]
                            ]
                        ]
                    } else  {
                        strong(cell.letter)
                    },
                    number: cell.number,
                    show-letter: show-solution,
                    letter-size: letter-size,
                    number-size: number-size,
                )
            }
        })
    )
}
