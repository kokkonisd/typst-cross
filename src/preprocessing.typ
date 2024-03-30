// Process a dictionary and produce cell and clue data.
//
// The dictionary is expected to come from a TOML file, usually by doing `toml("myfile.toml")`. It
// is also expected to have the following structure (in Typst notation):
//
// ```typst
// (
//     title: "Title",
//     author: "Author",
//     board: "1234\nABCD\nabcd\n####",
//     clues: (
//         across: (
//             (
//                 row: 1,
//                 column: 1,
//                 clue: "This is an across clue",
//             )
//         ),
//         across: (
//             (
//                 row: 1,
//                 column: 1,
//                 clue: "This is a down clue",
//             )
//         ),
//     ),
// )
// ```
//
// Also see the TOML files in `examples/`.
//
// The cell and clue data produced by this function has the following form (in Typst notation):
// ```typst
// (
//     width: 100,            // Width of the board.
//     height: 80,            // Height of the board.
//     next_cell_number: 42,  // Number to mark next clue-starting cell with (internal use mostly).
//     cells: (
//         (
//             letter: "A",   // Letter contained in the cell.
//             number: 12,    // Number on the top left of the cell (if any).
//             row: 28,       // The cell's row.
//             column: 3,     // The cell's column.
//         ),
//     )
// )
// ```
#let _process_data(data) = {
    let width = data.board.position("\n")
    let height = data.board.split("\n").filter(n => n.len() > 0).len()

    data.board.clusters().filter(letter => letter != "\n").enumerate().fold(
        (
            width: width,
            height: height,
            next_cell_number: 1,
            cells: ()
        ),
        (state, (index, letter)) => {
            let row = int(index / width) + 1
            let column = (index - ((row - 1) * width)) + 1
            let next_cell_number = state.next_cell_number

            let new_cell = (letter: none, number: none, row: row, column: column)

            if data.clues.across.find(clue => {
                clue.row == row and clue.column == column
            }) != none {
                new_cell.letter = letter
                new_cell.number = state.next_cell_number
                next_cell_number = state.next_cell_number + 1
            } else if data.clues.down.find(clue => {
                clue.row == row and clue.column == column
            }) != none {
                new_cell.letter = letter
                new_cell.number = state.next_cell_number
                next_cell_number = state.next_cell_number + 1
            } else {
                new_cell.letter = letter
                new_cell.number = none
            }

            (
                width: width,
                height: height,
                next_cell_number: next_cell_number,
                cells: (..state.cells, new_cell)
            )
        }
    )
}
