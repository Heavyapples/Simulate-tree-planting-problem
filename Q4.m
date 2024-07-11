% 定义三角形区域的顶点
vertices = [0 0; 0 30; 20 0];

% 树的高度和对应的冠幅
tree_height = 1.0;
tree_crown_diameter = 0.30;
tree_crown_radius = tree_crown_diameter / 2;

% 安全距离
safety_distance = 2.35;

% 用于保存树的位置的数组
tree_positions = [];

% 迭代次数
iterations = 10000;

% 在每次迭代中，尝试添加一棵树到随机位置
for i = 1:iterations
    % 生成随机位置
    x = 20 * rand();
    y = 30 * rand();
    
    % 检查新的位置是否在三角形区域内
    if inpolygon(x, y, vertices(:,1), vertices(:,2))
        % 检查新的位置是否与其他树的距离大于冠幅的半径加上安全距离
        if isempty(tree_positions)
            tree_positions = [tree_positions; x y];
        else
            dist = sqrt((tree_positions(:, 1) - x).^2 + (tree_positions(:, 2) - y).^2);
            if min(dist) >= max([tree_crown_radius, safety_distance])
                tree_positions = [tree_positions; x y];
            end
        end
    end
end

% 打印结果
fprintf('在三角形区域内可以种植 %d 棵树.\n', size(tree_positions, 1));

% 绘制三角形区域和树的位置
figure;
fill(vertices(:,1), vertices(:,2), 'y');
hold on;
scatter(tree_positions(:,1), tree_positions(:,2), 'g');
axis equal;
title('树的种植位置');
xlabel('x (m)');
ylabel('y (m)');
