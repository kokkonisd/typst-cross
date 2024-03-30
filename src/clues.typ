#import "preprocessing.typ": *


// Produce a list of clues.
//
// This produces a simple enumerated list with all the clues from a clues dictionary (usually
// either `data.clues.across` or `data.clues.down`, coming from the crossword's TOML file), with
// each element having the appropriate clue number.
//
// Parameters:
// - `clues`: the dictionary of clues as found in the TOML file.
// - `data`: the data of the TOML file (that will be processed).
#let _clues_list(clues, data) = {
    enum(
        ..clues.map(clue => {
            let number = _process_data(data).cells.find(cell => {
                cell.row == clue.row and cell.column == clue.column
            }).number

            enum.item(number)[
                // Evaluate the clue as Typst code.
                #eval(clue.clue, mode: "markup")
            ]
        })
    )
}

// Produce the enumerated list of the "across" clues.
#let clues_across(data) = {
    _clues_list(data.clues.across, data)
}

// Produce the enumerated list of the "down" clues.
#let clues_down(data) = {
    _clues_list(data.clues.down, data)
}

// Produce a two-column display of both "across" and "down" clues, with headers.
#let clues(data) = grid(
    columns: (1fr, 2pt, 1fr),
    gutter: 10pt,
    block[
        = Across
        #clues_across(data)
    ],
    block(line(start: (0%, 0%), end: (0%, 100%))),
    block[
        = Down
        #clues_down(data)
    ],
)
