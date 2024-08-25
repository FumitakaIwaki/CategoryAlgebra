import Base.+
import Base.*

# 射の構造体
struct Arrow
    dom::Int
    cod::Int
    name::String
end

# 圏の行列の要素の構造体
struct Component
    arrows::Vector{Arrow}
    coef::Vector{Float64}
    coor::Tuple{Int, Int}
end


# 射同士の掛け算 = 射の合成
function *(arr1::Arrow, arr2::Arrow)
    if arr1.dom == arr2.cod
        if arr1.name == arr2.name
            return Arrow(arr2.dom, arr1.cod, arr1.name)
        else
            return Arrow(arr2.dom, arr1.cod, arr1.name * arr2.name)
        end
    else
        return Arrow(0, 0, "0")
    end
end


# 行列の構成要素同士の演算
# 掛け算
function *(cmp1::Component, cmp2::Component)
    _arrows = Vector{Arrow}()
    for p in Base.product(cmp1.arrows, cmp2.arrows)
        append!(_arrows, [p[1] * p[2]])
    end
    _arrows = _arrows[findall(x->x!=Arrow(0, 0, "0"), _arrows)]
    return Component(_arrows, ones(length(_arrows)), (cmp1.coor[1], cmp2.coor[2]))
end

# 足し算
function +(cmp1::Component, cmp2::Component)
    _arrows = copy(cmp1.arrows)
    _coef = copy(cmp1.coef)
    _coor = (cmp1.coor[1], cmp2.coor[2])

    for i in 1:length(cmp2.arrows)
        flag = true
        for j in 1:length(cmp1.arrows)
            if cmp2.arrows[i].name == cmp1.arrows[j].name
                _coef[j] += 1
                flag = false
            end
        end
        if flag
            append!(_arrows, [cmp2.arrows[i]])
            append!(_coef, [1])
        end
    end
    _arrows = _arrows[findall(x->x!=Arrow(0, 0, "0"), _arrows)]
    return Component(_arrows, _coef, _coor)
end