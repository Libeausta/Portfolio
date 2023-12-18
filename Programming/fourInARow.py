import numpy as np
from tkinter import *
import tkinter.font as font
import pygame

bg_color = (214, 165, 201)
fg_color = (247, 242, 190)
player1_color = (100, 163, 181)
player2_color = (87, 86, 150)

class Board:
    def __init__(self, row_count, column_count):
        self.row_count = row_count
        self.column_count = column_count
        self.grid = np.zeros((row_count, column_count))

    def crct_pos(self, column):
        return self.grid[self.row_count - 1, column] == 0

    def next_mypos(self, column):
        for row in range(self.row_count):
            if self.grid[row, column] == 0:
                return row

    def drop_piece(self, row, column, turn):
        self.grid[row, column] = turn

    def win_move(self, turn):
        for r in range(self.row_count):
            for c in range(self.column_count - 3):
                if self.grid[r, c] == turn and self.grid[r, c + 1] == turn and self.grid[r, c + 2] == turn and self.grid[r, c + 3] == turn:
                    return True

        for r in range(self.row_count - 3):
            for c in range(self.column_count):
                if self.grid[r, c] == turn and self.grid[r + 1, c] == turn and self.grid[r + 2, c] == turn and self.grid[r + 3, c] == turn:
                    return True

        for r in range(self.row_count - 3):
            for c in range(self.column_count - 3):
                if self.grid[r, c] == turn and self.grid[r + 1, c + 1] == turn and self.grid[r + 2, c + 2] == turn and self.grid[r + 3, c + 3] == turn:
                    return True

        for r in range(3, self.row_count):
            for c in range(self.column_count - 3):
                if self.grid[r, c] == turn and self.grid[r - 1, c + 1] == turn and self.grid[r - 2, c + 2] == turn and self.grid[r - 3, c + 3] == turn:
                    return True

        return False

    def is_full(self):
        return self.grid.all()

    def reset(self):
        self.grid = np.zeros((self.row_count, self.column_count))

    def print_grid(self):
        print(np.flip(self.grid, 0))


class Cells:
    def __init__(self, row_count, column_count, square_size):
        self.board = Board(row_count, column_count)
        self.square_size = square_size
        self.radius = square_size // 2 - 5
        self.width = column_count * square_size
        self.height = (row_count + 1) * square_size  
        self.offset = square_size  
        self.circle_offset = square_size // 2 
        self.screen = pygame.display.set_mode((self.width, self.height))

    def mybg(self):
        for r in range(self.board.row_count):
            for c in range(self.board.column_count):
                left = c * self.square_size
                top = r * self.square_size + self.offset
                pygame.draw.rect(self.screen, fg_color, (left, top, self.square_size, self.square_size))
                pygame.draw.circle(self.screen, bg_color, (left + self.circle_offset, top + self.circle_offset), self.radius)
        pygame.display.update()

    def fill_mypos(self):
        for r in range(self.board.row_count):
            for c in range(self.board.column_count):
                if self.board.grid[r, c] == 1:
                    current_color = player1_color
                elif self.board.grid[r, c] == 2:
                    current_color = player2_color
                else:
                    current_color = bg_color
                x_position = c * self.square_size + self.circle_offset
                y_position = self.height - (r * self.square_size + self.circle_offset)  
                pygame.draw.circle(self.screen, current_color, (x_position, y_position), self.radius)
        pygame.display.update()

    def track_mouse_motion(self, x_position, current_color):
        pygame.draw.rect(self.screen, bg_color, (0, 0, self.width, self.square_size)) 
        pygame.draw.circle(self.screen, current_color, (x_position, self.circle_offset), self.radius)
        pygame.display.update()

    def drop_mypos(self, x_position, turn):
        column_selection = x_position // self.square_size
        if self.board.crct_pos(column_selection):
            row = self.board.next_mypos(column_selection)
            self.board.drop_piece(row, column_selection, turn)
            return True
        return False

    def reset(self):
        self.screen = pygame.display.set_mode((self.width, self.height))
        self.board.reset()
        self.mybg()
        self.fill_mypos()


def game_result(winner = False):
    root = Tk()
    root.title("Завершение игры")
    root.geometry("500x150+110+130")
    root["bg"] = "#d6a5c9"
    main_font = font.Font(family="Arial", size=12)

    if winner:
        label = Label(text = f'Игрок {winner} одержал победу!', font=main_font, background="#F7F2E4", foreground="black")
        label.pack(expand=True, ipadx=10, ipady=10)
    else:
        label = Label(text = f'Поле заполнено, ничья!', font=main_font, background="#F7F2E4", foreground="black")
        label.pack(expand=True, ipadx=10, ipady=10)
    root.mainloop()

def main():
    pygame.init()
    pygame.display.set_caption('Игра "4 в ряд"')
    cell = Cells(6, 6, 90)
    cell.mybg()
    turn = 1
    current_color = player1_color
    playing = False
    while not playing:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                playing = True
                break

            elif event.type == pygame.MOUSEMOTION:
                cell.track_mouse_motion(event.pos[0], current_color)

            elif event.type == pygame.MOUSEBUTTONDOWN:
                if cell.drop_mypos(event.pos[0], turn):
                    cell.fill_mypos()
                    if cell.board.win_move(turn): 
                        playing = game_result(turn)
                        cell.reset()
                    elif cell.board.is_full():  
                        playing = game_result()
                        cell.reset()
                    else:  
                        turn = 1 if turn == 2 else 2  
                        current_color = player1_color if turn == 1 else player2_color 
                        cell.track_mouse_motion(event.pos[0], current_color) 

if __name__ == "__main__":
    main()