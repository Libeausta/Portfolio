import turtle as t

turtle = t.Turtle()
t.shape('turtle')
screen = t.Screen()
screen.bgcolor('#e3f3ff')
t.pensize(4)
t.speed(1000)
def shape(size,sides):
    for i in range(sides):
        t.forward(size)
        t.left(360/sides)

for j in range(6):
    for i in range(6):
        for colours in ['#a57ef7','#804bf2','#8017e8','#860be3','#9d38eb','#b86ef0','#d6aef5']:
            t.color(colours)
            shape(40,6)
            t.forward(10)
        t.right(60)
    t.left(60)
    t.penup()
    t.forward(80)
    t.pendown()
t.exitonclick()

