% 树高和相应冠幅
tree_height = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
tree_crown_diameter = [0.30, 0.89, 1.49, 2.08, 2.68, 3.28, 3.87, 4.47, 5.06, 5.66];
plus_meters = [2.35,2.055,1.755,1.46,1.16,0.86,0.565,0.265,0,0];

% 计算每棵树所需的总面积（平方米）
tree_total_area = zeros(1, length(tree_height));
land_area = zeros(1, length(tree_height));
for i = 1:length(tree_height)
    land_area(i) = (500 + 2*plus_meters(i)) * (500 + 2*plus_meters(i));
    tree_crown_radius = tree_crown_diameter(i) / 2;
    tree_safety_radius = tree_crown_radius + plus_meters(i);
    % 圆形的外接正方形面积
    square_area = (2 * tree_safety_radius)^2;
    % 圆形的面积
    circle_area = pi * tree_safety_radius^2;
    % 四个角落的面积
    corners_area = square_area - circle_area;
    tree_total_area(i) = max([10, circle_area + corners_area]);
end

% 计算在给定地块上最多可以种植的数量
max_tree_number = floor(land_area ./ tree_total_area);

% 打印结果
for i = 1:length(tree_height)
    fprintf('对于树高 %.1f m 的树, 场地中最多能种植的数量为 %d 棵.\n', tree_height(i), max_tree_number(i));
end
