--[[
Referencias
Tomado de: https://gist.github.com/tarleb/a0646da1834318d4f71a780edaf9f870
https://github.com/jgm/pandoc/issues/7743

]]

--[[
Add support for a custom inline syntax.
This pandoc Lua filter allows to add a custom markup syntax
extension. It is designed to be adjustable; it should not be
necessary to modify the code below the separator line.
The example here allows to add highlighted text by enclosing the
text with `==` on each side. Pandoc supports this for HTML output
out of the box. Other outputs will need additional filters.
Copyright: © 2022 Albert Krewinkel
License: MIT
]]

-- Lua pattern matching the opening markup string.
local opening = [[==]]

-- Lua pattern matching the closing markup string.
local closing = [[==]]

-- Toggle whether the opening markup may be followed by whitespace.
local nospace = true

-- Function converting the enclosed inlines to their internal pandoc
-- representation.
local function markup_inlines (inlines)
  return pandoc.Span(inlines, {class="mark"})
end

------------------------------------------------------------------------

local function is_space (inline)
  return inline and
    (inline.t == 'Space' or
     inline.t == 'LineBreak' or
     inline.t == 'SoftBreak')
end

function Inlines (inlines)
  local result = pandoc.Inlines{}
  local markup = nil
  local start = nil
  for i, inline in ipairs(inlines) do
    if inline.tag == 'Str' then
      if not markup then
        local first = inline.text:match('^' .. opening .. '(.*)')
        if first then
          start = inline -- keep element around in case the
                         -- markup is not closed. Check if the
                         -- closing pattern is already in this
                         -- string.
          local selfclosing = first:match('(.*)' .. closing .. '$')
          if selfclosing then
            result:insert(markup_inlines{pandoc.Str(selfclosing)})
          elseif nospace and first == '' and is_space(inlines[i+1]) then
            -- the opening pattern is followed by a space, but the
            -- config disallows this.
            result:insert(inline)
          else
            markup = pandoc.Inlines{pandoc.Str(first)}
          end
        else
          result:insert(inline)
        end
      else
        local last = inline.text:match('(.*)' .. closing .. '$')
        if last then
          markup:insert(pandoc.Str(last))
          result:insert(markup_inlines(markup))
          markup = nil
        else
          markup:insert(inline)
        end
      end
    else
      local acc = markup or result
      acc:insert(inline)
    end
  end

  -- keep unterminated markup
  if markup then
    markup:remove(1) -- the stripped-down first element
    result:insert(start)
    result:extend(markup)
  end
  return result
end
------------------------------------
-- https://forum.obsidian.md/t/rendering-callouts-similarly-in-pandoc/40020/6
local stringify = (require "pandoc.utils").stringify

function BlockQuote (el)
    start = el.content[1]
    if (start.t == "Para" and start.content[1].t == "Str" and
        start.content[1].text:match("^%[!%w+%][-+]?$")) then
        _, _, ctype = start.content[1].text:find("%[!(%w+)%]")
        el.content:remove(1)
        start.content:remove(1)
        div = pandoc.Div(el.content, {class = "callout"})
        div.attributes["data-callout"] = ctype:lower()
        div.attributes["title"] = stringify(start.content):gsub("^ ", "")
        div.attributes["custom-style"] = "Callout"
        return div
    else
        return el
    end
end

-----
-- Filtro para convertir <br> en pandoc.LineBreak

function LineBreak(el)
  if el.text:match("<br%s*/?>") then
    return pandoc.LineBreak()
  end
end


