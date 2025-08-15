-- gui.lua
function box(x, y, w, h, bg)
    term.setBackgroundColor(bg)
    for i = 0, h-1 do
        term.setCursorPos(x, y + i)
        term.write(string.rep(" ", w))
    end
end

function text(x, y, t, fg, bg)
    term.setTextColor(fg)
    term.setBackgroundColor(bg)
    term.setCursorPos(x, y)
    term.write(t)
end
-- gui.lua (ergänzt)
buttons = {}

function button(x, y, w, h, text, onClick)
    local btn = {x=x, y=y, w=w, h=h, text=text, onClick=onClick}
    table.insert(buttons, btn)
    drawButton(btn)
    return btn
end

function drawButton(btn)
    gui.box(btn.x, btn.y, btn.w, btn.h, colors.lightGray)
    local tx = btn.x + math.floor((btn.w - #btn.text)/2)
    local ty = btn.y + math.floor(btn.h/2)
    gui.text(tx, ty, btn.text, colors.black, colors.lightGray)
end

function checkButtonClick(mx, my)
    for _, btn in ipairs(buttons) do
        if mx >= btn.x and mx <= btn.x + btn.w - 1 and my >= btn.y and my <= btn.y + btn.h - 1 then
            if btn.onClick then btn.onClick() end
        end
    end
end
