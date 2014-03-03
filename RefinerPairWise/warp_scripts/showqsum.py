#!/usr/bin/python

import subprocess

p = subprocess.Popen("showq > showq.txt", stdout=subprocess.PIPE, shell=True)
p.wait()

filterLine = ["ACTIVE JOBS","IDLE JOBS","BLOCKED JOBS","JOBNAME"]
dataFiltered = []
for l in file("showq.txt"):
    ignoreLine = False
    for filter in filterLine:
        if l.startswith(filter):
            ignoreLine = True
            break
    if l.find(" of ") != -1:
        print l[:-1]
    if ignoreLine or l.startswith(" ") or l.strip() == "" or l.find("Job") != -1:
        continue
    dataFiltered.append(l.strip())	

userData = {}

for l in dataFiltered:
    while l.find("  ") != -1:
        l = l.replace("  "," ")
    jobId, username, status, coreCount, tl, started = l.split(" ",5)
    if username not in userData:
        userData[username] = []
    userData[username].append((status, int(coreCount)))

statuses = ["Running","Idle","Blocked","Deferred"]
for username in userData:
    perStatus = {}
    for status, coreCount in userData[username]:
        if status not in perStatus:
            perStatus[status] = [0, 0]
        perStatus[status][0] += 1
        perStatus[status][1] += coreCount
    print username
    for status in statuses:
        if status not in perStatus:
            continue
        print status, perStatus[status][0], perStatus[status][1] 
    print "-"*10
    
