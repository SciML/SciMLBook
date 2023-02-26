using Weave

function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

"""
    \\weave{
    ```julia
    # some Julia code ...
    ```
    }

A simple command to render and evaluate code chunk in Weave.jl-like way.
"""
function lx_weave(com, _)
    content = Franklin.content(com.braces[1])
    lines = split(content, '\n')
    Core.eval(Main, :(lines = $(lines)))

    i = findfirst(startswith("```julia"), lines)
    @assert !isnothing(i) "couldn't find Weave.jl header"
    lines = lines[i:end]

    header = first(lines)
    id = string("weave-chunk-id-", hash(gensym()))
    lines[1] = string(header, ':', id)

    push!(lines, "\\show{$(id)}")

    return join(lines, '\n')
end

function hfun_augment_insert(params)
    rpath = params[1]
    fullpath = joinpath(Franklin.path(:folder), rpath)
    (isfile(fullpath) && splitext(fullpath)[2] == ".html") || return ""
    @info "Augmenting $(rpath)... "
    html = read(fullpath, String)
    anchored_html = replace(html, r"<h(?<level>[1-3]) class=\"title\">(?<title>.+?)</h[1-3]>"ms => s"<h\g<level> class=\"header-anchor\"><a href=\"#\g<title>\">\g<title></a></h\g<level>>")
    finished_html = replace(anchored_html, r"</h(?<level>[1-3])>" => s"</a></h\g<level>")
    @info "✓ [done]."
    return finished_html
end
