#import "preprocessing.typ": *


// Produce a white cell of the crossword's board.
//
// Parameters:
// - `letter`: the letter to place in the cell.
// - `number`: the number to display on the top left corner of the cell (if any).
// - `show_letter`: if `true`, show the letter of the cell.
// - `letter_size`: the size of the letter of the cell.
// - `number_size`: the size of the number of the cell (if any).
#let _white_cell(
    letter,
    number: none,
    show_letter: false,
    letter_size: none,
    number_size: none,
) = rect(width: 100%, height: 100%, stroke: 1pt + black)[
    #if show_letter == true {
        align(center + horizon)[
            #text(letter, size: letter_size)
        ]
    }

    #if number != none {
        place(top + left)[
            #text([#number], size: number_size)
        ]
    }
]

// Produce a black cell of the crossword's board.
#let _black_cell() = rect("", width: 100%, height: 100%, fill: black, stroke: 1pt + black)

// Produce the crossword board.
//
// Parameters:
// - `data`: the data loaded from the crossword's TOML file. See `preprocessing.typ`.
// - `show_solution`: if `true`, show the solution to the crossword.
// - `show_cell_coordinates`: if `true` (and `show_solution` is also `true`), display the
//   coordinates of the cells below the letters. This is useful when debugging or placing clues.
// - `cell_size`: the size of the cells of the board.
// - `letter_size`: the size of the letter of each cell.
// - `number_size`: the size of the number of each cell (if any).
#let board(
    data,
    show_solution: false,
    show_cell_coordinates: false,
    cell_size: 30pt,
    letter_size: 11pt,
    number_size: 8pt,
) = {
    let data = _process_data(data)

    grid(
        columns: range(data.width).map(n => cell_size),
        rows: range(data.height).map(n => cell_size),

        ..data.cells.map(cell => {
            if cell.letter == "#" {
                _black_cell()
            } else {
                _white_cell(
                    if show_cell_coordinates {
                        [
                            #strong(cell.letter)
                            #place(bottom + center)[
                                #text(size: number_size)[
                                    #cell.row, #cell.column
                                ]
                            ]
                        ]
                    } else  {
                        strong(cell.letter)
                    },
                    number: cell.number,
                    show_letter: show_solution,
                    letter_size: letter_size,
                    number_size: number_size,
                )
            }
        })
    )
}
