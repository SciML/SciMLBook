using Franklin
using Weave


"""
    weaveall()

Weave all lecture notes in the `_weave` directory. Run from site root.
"""
function weaveall()
    for (root, _, files) in walkdir("_weave")
        for file in files
            if endswith(file, "jmd")
                @info "Weaving Document: $(joinpath(root, file))"
                weave(joinpath(root, file); out_path=:doc, mod=Main)
            end
        end
    end
end


"""
    cleanall()

Cleanup all Weave generated subdirectories. Run from site root.
"""
function cleanall()
    for (root, dirs, _) in walkdir("_weave")
        for dir in dirs
            if startswith(dir, "jl_")
                @info "Removing Directory: $(joinpath(root, dir))"
                rm(joinpath(root, dir); recursive=true, force=true)
            end
        end
    end
end

function hfun_insert_weave(params)
    rpath = params[1]
    fullpath = joinpath(Franklin.path(:folder), rpath)
    (isfile(fullpath) && splitext(fullpath)[2] == ".jmd") || return ""
    @info "Weaving... "
    t = tempname()
    weave(fullpath; out_path=t, mod=Main)
    @info "✓ [done]."
    fn = splitext(splitpath(fullpath)[end])[1]
    html = read(joinpath(t, fn * ".html"), String)
    start = findfirst("<BODY>", html)
    finish = findfirst("</BODY>", html)
    range = nextind(html, last(start)):prevind(html, first(finish))
    html = html[range]
    anchored_html = replace(html,
        r"<h(?<level>[1-3]) class=\"title\">" => s"<h\g<level> class=\"header-anchor\">")
    return anchored_html
end

