import re
import subprocess
whiteWinRate = 0
blackWinRate = 0
drawRate = 0

NOMBRE_ITERATIONS = 2000
step = 1 / (NOMBRE_ITERATIONS / 100)

for j in range(0, NOMBRE_ITERATIONS):
    # Lancement du processus
    result = subprocess.run(['swipl', '-s', 'main.pl', '-t', 'init'], stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)

    resultLine = result.stdout.decode('utf-8')
    if resultLine[22] == 'W':
        whiteWinRate += step
    elif resultLine[22] == 'B':
        blackWinRate += step
    else:
        drawRate += step

    print("Match", j, "/", NOMBRE_ITERATIONS, "has been played")


print("White win rate: ", whiteWinRate, "%")
print("Black win rate: ", blackWinRate, "%")
print("Draw rate: ", drawRate, "%")


