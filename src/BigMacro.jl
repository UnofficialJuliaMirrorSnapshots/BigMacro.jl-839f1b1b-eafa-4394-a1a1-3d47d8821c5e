module BigMacro

using MacroTools: prewalk

export @bigfloat, @bigint

macro bigfloat(ex)
    esc(_bigfloat(ex))
end

function _bigfloat(ex)
    prewalk(ex) do x
        applicable(BigFloat, x) ? BigFloat(x) : x
    end
end

macro bigfloat(precision, ex)
    esc(_bigfloat(precision, ex))
end

function _bigfloat(precision, ex)
    quote
        setprecision($precision) do
            @bigfloat $ex
        end
    end
end

macro bigint(ex)
    esc(_bigint(ex))
end

function _bigint(ex)
    prewalk(ex) do x
        applicable(BigInt, x) ? BigInt(x) : x
    end
end

end
