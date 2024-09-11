declare global upperLeftRow is 0.
declare global upperRightRow is 0.
declare global bottomLeftRow is 0.
declare global bottomRightRow is 0.


declare function PrintUpperLeft {
    parameter text.

    local row is upperLeftRow.
    local col is 0.
    // set col to terminal:width - text:length.
    
    print text at (col, row).
    set upperLeftRow to upperLeftRow + 1.
}

declare function PrintUpperRight {
    parameter text.

    local row is upperRightRow.
    local col is 0.
    set col to terminal:width - text:length.
    
    print text at (col, row).
    set upperRightRow to upperRightRow + 1.
}

declare function PrintBottomLeft{
    parameter text.

    local row is bottomLeftRow.
    local col is 0.
    set row to terminal:height - 1.
    
    print text at (col, row).
    set bottomLeftRow to bottomLeftRow + 1.
}

declare function PrintBottomRight {
    parameter text.

    local row is bottomRightRow.
    local col is 0.
    
    set col to terminal:width - text:length.
    set row to terminal:height - 1.
    
    print text at (col, row).
    set bottomRightRow to bottomRightRow + 1.
}