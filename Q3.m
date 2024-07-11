% 安全距离数组
safety_distance = [2.35,2.055,1.755,1.46,1.16,0.86,0.565,0.265,0,0];

% 树高和相应冠幅的数据
tree_height = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
tree_crown_diameter = [0.30, 0.89, 1.49, 2.08, 2.68, 3.28, 3.87, 4.47, 5.06, 5.66];

% 土地边界
land_boundary = [500, 500];

% 随机生成树木的数据
num_planted_trees = round(300 + 2000 * rand()); 
planted_tree_height = round(1 + 9 * rand(num_planted_trees, 1));
planted_tree_pos = land_boundary .* rand(num_planted_trees, 2); 
planted_trees = [planted_tree_pos, planted_tree_height];
 
for i = 1:num_planted_trees
    % 对每棵树尝试增加高度
    for j = planted_trees(i, 3) + 1 : 10
        current_tree_height = j;
        current_tree_crown_radius = interp1(tree_height, tree_crown_diameter, current_tree_height) / 2;

        % 检查是否满足安全距离的要求
        current_safety_distance = interp1(tree_height, safety_distance, current_tree_height);  % 根据树高得到安全距离
        dist = sqrt(sum((planted_tree_pos - planted_tree_pos(i, :)).^2, 2));
        dist(i) = inf; % Exclude self
        if min(dist) < 2 * (current_tree_crown_radius + current_safety_distance)  % 使用当前的安全距离
            % 如果不满足要求，降低树高
            planted_trees(i, 3) = planted_trees(i, 3) - 1;
            break;
        end

        % 检查树冠是否超出土地边界
        if any(planted_tree_pos(i, :) - current_tree_crown_radius < 0) || any(planted_tree_pos(i, :) + current_tree_crown_radius > land_boundary)
            % 如果不满足要求，降低树高
            planted_trees(i, 3) = planted_trees(i, 3) - 1;
            break;
        end

        % 如果满足所有要求，增加树高
        planted_trees(i, 3) = current_tree_height;
    end
end

% 删除高度为0的树
planted_trees(planted_trees(:, 3) == 0, :) = [];

% 打印结果
for i = 1:size(planted_trees, 1)
    fprintf('树%d的位置为 (%.2f, %.2f), 高度为 %d m.\n', i, planted_trees(i, 1), planted_trees(i, 2), planted_trees(i, 3));
end

