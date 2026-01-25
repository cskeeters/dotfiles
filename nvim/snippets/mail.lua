local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt   -- default delimiters are {}
local conditions = require("luasnip.extras.conditions")

function rcc()
    return fmt([=[```{{=html}}
<div style="font-family: system-ui, sans-serif; font-size: 9pt;">
    <span style="font-size:11pt">
        <span style="letter-spacing: .3pt"><b>Chad Skeeters</b></span><br>
        BCS-T Program Manager<br>
        Phone: 210.538.4779<br>
    </span>
    <span style="font-size:11pt;color:#C00000; letter-spacing: .3pt">
        <b>Red Cedar Consultancy, LLC</b><br>
    </span>
    <span style="color:#595959; font-size:11pt">
        <b>SBA Certified 8(a) and HUBZone Small Business</b><br>
    </span>
    <span style="color:#595959; font-family: Roboto Condensed">
        NITAAC CIO-SP3 SB, Air Force SBEAS, SEC OneIT, SeaPort-NxG, SBA Microsoft BPA, GSA MAS<br>
        CMMI Level 3 (DEV & SVC), ISO 9001, 20000, and 27001 Certified<br>
        <span style="font-size:9pt; color:#C00000">11835 IH 10 West Suite 301, San Antonio, TX 78230</span>
    </span>
</div>
```]=],
        {},
        {
            -- This enables me to use spaces to indent the format argument and fmt will convert instances
            -- of indent_string to the unit indent string for me.
            indent_string = '    '
        }
    )
end

function wp()
    return fmt([=[
Chad Skeeters
Walden Point HOA
President, Treasurer]=],
        {},
        {
            -- This enables me to use spaces to indent the format argument and fmt will convert instances
            -- of indent_string to the unit indent string for me.
            indent_string = '    '
        }
    )
end


return {
    s(
        {trig = "vr", desc="Inserts RCC Signature (V/R)"},
        {
            t({
                'V/R,',
                '',
                '',
            }),
            unpack(rcc()),
        }
    ),

    s(
        {trig = "thanks", desc="Inserts RCC Signature (Sincearly,)"},
        {
            t({
                'Thanks,',
                '',
                '',
            }),
            unpack(rcc()),
        }
    ),

    s(
        {trig = "sin", desc="Inserts RCC Signature (Sincearly)"},
        {
            t({
                'Sincearly,',
                '',
                '',
            }),
            unpack(rcc()),
        }
    ),

    s(
        {trig = "rcc", desc="Inserts RCC Signature"},
        rcc()
    ),

    s(
        {trig = "wp", desc="Inserts Walden Point Signature"},
        wp()
    )
}
