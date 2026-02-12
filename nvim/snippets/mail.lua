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
<div style="font-family: Arial, sans-serif; color:#595959; line-height: 1.1em; letter-spacing: 0.2pt;">

    <div style="font-size: 11pt">

        <div style="font-weight:700; margin: 0">
            Chad Skeeters
        </div>
        <div style="margin: 0">
            BCS-T Program Manager
        </div>
        <div style="margin: 0">
            (210) 538-4779
        </div>
        <div style="color: #C00000; font-weight:700; margin: 0">
            Red Cedar Consultancy, LLC
        </div>
        <div style="font-family: Arial, sans-serif; line-height: 1.1em; font-size:9pt; color:#C00000; margin: 0">
            8201 Greensboro Dr, Suite 500, McLean, VA 22102
            <!-- 11835 IH 10 West Suite 301, San Antonio, TX 78230 -->
        </div>
        <div style="font-weight: bold; margin: 0">
            <b>SBA Certified 8(a) and HUBZone Small Business</b>
        </div>
    </div>
    <div style="font-size: 9pt; font-family: Arial Narrow, sans-serif; line-height: 1.1em;">
        <div style="margin: 0">
            NITAAC CIO-SP3 <span style="color:#C00000">|</span>
            GSA MAS <span style="color:#C00000">|</span>
            Air Force SBEAS <span style="color:#C00000">|</span>
            OASIS+ <span style="color:#C00000">|</span>
            POLARIS <span style="color:#C00000">|</span>
            JETS 2.0 <span style="color:#C00000">|</span>
            SEC OneIT <span style="color:#C00000">|</span>
            MDA SHIELD
        </div>
        <div style="margin:0">
            ISO 9001:2015     <span style="color:#C00000">|</span>
                20000-1:2018  <span style="color:#C00000">|</span>
                27001:2022
        </div>
        <div style="margin:0">
            CMMI DEV/3 <span style="color:#C00000">|</span> SVC/3
        </div>
        <div style="margin:0">
            SALED AGILE PARTNER - SILVER
        </div>
    </div>
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
    ),

    s(
        {trig = "sherm", desc="Games Gates"},
        {
            t('"James Gates" <james.gates.13@us.af.mil>')
        }
    ),

    s(
        {trig = "gaddy", desc="Jimmy Gaddy"},
        {
            t('"Jimmy Gaddy" <jimmy.gaddy@redcedarconsultancy.com>')
        }
    ),

    s(
        {trig = "sharad", desc="Sharad Gumaste"},
        {
            t('"Sharad Gumaste" <sharad@redcedarconsultancy.com>')
        }
    ),

    s(
        {trig = "david", desc="David Wettstein"},
        {
            t('"David Wettstein" <david.wettstein.ctr@us.af.mil>')
        }
    ),

    s(
        {trig = "osst", desc="OSST"},
        {
            t('"David Wettstein" <david.wettstein.ctr@us.af.mil>, "Tauren Baptiste" <tauren.baptiste.1.ctr@us.af.mil>, "Spence Johnson" <spence.johnson.2.ctr@us.af.mil>')
        }
    ),

    s(
        {trig = "chad", desc="Chad (RCC)"},
        {
            t('"Chad Skeeters" <chad.skeeters@redcedarconsultancy.com>')
        }
    ),
}
