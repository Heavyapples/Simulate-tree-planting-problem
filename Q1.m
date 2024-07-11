% 地块面积（平方米）
land_area = (500 + 2*2.35) * (500 + 2*2.35);

% 树高和相应冠幅
tree_height = 1;
tree_crown_diameter = 0.3;

% 计算每棵树所需的总面积（平方米）
tree_crown_radius = tree_crown_diameter / 2;
tree_safety_radius = tree_crown_radius + 2.35;
% 圆形的外接正方形面积
square_area = (2 * tree_safety_radius)^2;
% 圆形的面积
circle_area = pi * tree_safety_radius^2;
% 四个角落的面积
corners_area = square_area - circle_area;
tree_total_area = max([10, circle_area + corners_area]);

% 计算在给定地块上最多可以种植的数量
max_tree_number = floor(land_area ./ tree_total_area);

% 打印结果
fprintf('对于树高 %.1f m 的树, 场地中最多能种植的数量为 %d 棵.\n', tree_height, max_tree_number);

% 绘制场地和树木
figure;
% 绘制扩充后的场地
rectangle('Position', [-2.35, -2.35, 500+2*2.35, 500+2*2.35], 'LineStyle', '--');
hold on;
% 绘制原始场地
rectangle('Position', [0, 0, 500, 500]);
hold on;
% 计算树木的位置
x = 0.15 : tree_safety_radius : 500;
y = 0.15 : tree_safety_radius : 500;
[X, Y] = meshgrid(x, y);
centers = [X(:), Y(:)];
% 绘制树木
viscircles(centers, repmat(tree_crown_radius, size(centers, 1), 1));
axis equal;
title('树木种植图');
xlabel('x (m)');
ylabel('y (m)');
