#import "@local/cross:0.0.2" as cross

#set page(margin: 1cm)

#let crossword-data = toml("data.toml")


#align(center)[
    = #crossword-data.title \
    by #crossword-data.author

    #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 20pt,
        align: center + bottom,

        // Show the board.
        [
            Empty board
            #cross.board(crossword-data)
        ],

        // Show the board with the solution on it.
        [
            Board with solution
            #cross.board(crossword-data, show-solution: true)
        ],

        // Show the board with the solution and the cell coordinates (helps when building the
        // crossword).
        [
            Board with solution & cell coordinates
            #cross.board(crossword-data, show-solution: true, show-cell-coordinates: true)
        ],
    )
]

#v(1cm)

#block(height: 500pt)[
    #cross.clues(crossword-data)
]
