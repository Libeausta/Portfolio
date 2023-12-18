import pygame
from random import random
from collections import deque
def rect(x, y):
    return x * bar + 1, y * bar + 1, bar - 2, bar - 2

def next_nodes(x, y):
    check_node = lambda x, y: True if 0 <= x < column and 0 <= y < row and not grid[y][x] else False
    ways = [-1, 0], [0, -1], [1, 0], [0, 1], [-1, -1], [1, -1], [1, 1], [-1, 1]
    return [(x + dx, y + dy) for dx, dy in ways if check_node(x + dx, y + dy)]

def click_pos():
    x, y = pygame.mouse.get_pos()
    grid_x, grid_y = x // bar, y // bar
    pygame.draw.rect(screen, pygame.Color(148,50,145), rect(grid_x, grid_y))
    click = pygame.mouse.get_pressed()
    return (grid_x, grid_y) if click[0] else False

def bfs(start, goal, graph):
    queue = deque([start])
    visited = {start: None}

    while queue:
        cur_node = queue.popleft()
        if cur_node == goal:
            break

        next_nodes = graph[cur_node]
        for next_node in next_nodes:
            if next_node not in visited:
                queue.append(next_node)
                visited[next_node] = cur_node
    return queue, visited

column, row = 20, 15
bar = 50
pygame.init()
screen = pygame.display.set_mode([column * bar, row * bar])
clock = pygame.time.Clock()

grid = [[1 if random() < 0.2 else 0 for col in range(column)] for r in range(row)]
graph = {}
for y, r in enumerate(grid):
    for x, col in enumerate(r):
        if not col:
            graph[(x, y)] = graph.get((x, y), []) + next_nodes(x, y)

#цвет бледно-голубой/твиттера
start = (0, 0)
goal = start
queue = deque([start])
visited = {start: None}
running = True
while running:
    screen.fill(pygame.Color(221,238,255))
    [[pygame.draw.rect(screen, pygame.Color(128,189,104), rect(x, y), border_radius = bar // 5) for x, col in enumerate(row) if col] for y, row in enumerate(grid)]
    [pygame.draw.rect(screen, pygame.Color(197,208,230), rect(x, y)) for x, y in visited]
    [pygame.draw.rect(screen, pygame.Color(197,208,230), rect(x, y)) for x, y in queue]

    mouse_pos = click_pos()
    if mouse_pos and not grid[mouse_pos[1]][mouse_pos[0]]:
        queue, visited = bfs(start, mouse_pos, graph)
        goal = mouse_pos
    path_head, path_segment = goal, goal
    while path_segment and path_segment in visited:
        pygame.draw.rect(screen, pygame.Color(71,163,255), rect(*path_segment), bar, border_radius = bar // 3)
        path_segment = visited[path_segment]
    pygame.draw.rect(screen, pygame.Color(71,163,255), rect(*start), border_radius = bar // 3)
    pygame.draw.rect(screen, pygame.Color(186,63,182), rect(*path_head), border_radius = bar // 3)
    pygame.display.flip()
    clock.tick(30)
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
pygame.quit()
