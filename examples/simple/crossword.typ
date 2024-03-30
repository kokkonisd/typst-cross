#import "@local/cross:0.0.1" as cross

#set page(margin: 1cm)

#let crossword_data = toml("data.toml")


#align(center)[
    = #crossword_data.title \
    by #crossword_data.author

    #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 20pt,
        align: center + bottom,

        // Show the board.
        [
            Empty board
            #cross.board(crossword_data)
        ],

        // Show the board with the solution on it.
        [
            Board with solution
            #cross.board(crossword_data, show_solution: true)
        ],

        // Show the board with the solution and the cell coordinates (helps when building the
        // crossword).
        [
            Board with solution & cell coordinates
            #cross.board(crossword_data, show_solution: true, show_cell_coordinates: true)
        ],
    )
]

#v(1cm)

#block(height: 500pt)[
    #cross.clues(crossword_data)
]
