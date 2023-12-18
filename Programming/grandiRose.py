print('Многолепестковая роза Гранди')
import turtle, math
screen = turtle.Screen()
screen.setup(700,700)
screen.tracer(0)

t = turtle.Turtle()
t.speed(0)
t.hideturtle()
turtle.color('#801653')
d = 300
a = 0
count = 0.601
ro = d*math.sin(count*a)
x = ro*math.sin(a)
y = ro*math.cos(a)

while a<=270:
    turtle.setpos(x,y)
    a+=0.05
    ro = d*math.sin(count*a)
    x = ro*math.sin(a)
    y = ro*math.cos(a)
screen.exitonclick()
