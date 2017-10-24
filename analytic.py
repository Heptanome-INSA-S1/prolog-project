import re
import subprocess
import datetime
import sys
whiteWinRate = 0
blackWinRate = 0
drawRate = 0

try:
    NOMBRE_ITERATIONS = int(sys.argv[1])
except:
    NOMBRE_ITERATIONS = 2000

print(NOMBRE_ITERATIONS)

step = 1 / (NOMBRE_ITERATIONS / 100)
start = datetime.datetime.now()
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

    end = datetime.datetime.now()

    duration = end - start
    duration /= j+1
    duration *= NOMBRE_ITERATIONS - j

    if (j *100) % NOMBRE_ITERATIONS == 0:
        print((j * 100) / NOMBRE_ITERATIONS, "% reached")
        print(duration, "estimate remaining time...")


print("White win rate: ", whiteWinRate, "%")
print("Black win rate: ", blackWinRate, "%")
print("Draw rate: ", drawRate, "%")


