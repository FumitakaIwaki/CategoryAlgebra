include("../src/calculation.jl")

# 1 -(f, g)-> 2  
# 1 <-(h)- 2

# 対象
objects = [1, 2]
# 射
arrows = Dict(
    "id1" => Arrow(1, 1, "id1"),
    "f" => Arrow(1, 2, "f"),
    "g" => Arrow(1, 2, "g"),
    "h" => Arrow(2, 1, "h"),
    "id2" => Arrow(2, 2, "id2"),
)
# 圏の行列の構成要素
cmp11 = Component([arrows["id1"]], ones(1), (1, 1))
cmp12 = Component([arrows["f"], arrows["g"]], ones(2), (1, 2))
cmp21 = Component([arrows["h"]], ones(1), (2, 1))
cmp22 = Component([arrows["id2"]], ones(1), (2, 2))
# 圏
category = [
    cmp11 cmp12
    cmp21 cmp22
]

# 自乗の計算
category_2 = category^2
# 結果の表示
for i in 1:size(category_2)[1]
    for j in 1:size(category_2)[2]
        println(category_2[i, j])
    end
end