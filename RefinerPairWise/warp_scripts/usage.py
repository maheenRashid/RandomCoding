#!/usr/bin/python
import os

os.system("qstat -f > qstat.txt")
data = file("qstat.txt").read()
dataSplit = data.split("Job Id")

hosts = {}
hostUser = {}
allUsers = []

for item in dataSplit[1:]:
	#total hack
	ownerStart = item.find("Job_Owner")
	cputStart = item.find("resources_used.cput")	
	if cputStart == -1:
		continue
	execStart = item.find("exec_host")
	HoldTypeStart = item.find("Hold_Type")
	if HoldTypeStart == -1:
		HoldTypeStart = item.find("Join_Path")
	name = item[ownerStart+11:cputStart].strip().split("@")[0]
	hostString = item[execStart+12:HoldTypeStart].strip().replace("\n","").replace(" ","").replace("\t","")
	for host in hostString.split("+"):
		hostname,cpuid = host.split("/")
		if hostname not in hosts:
			hosts[hostname] = []
		hosts[hostname].append(cpuid)
		if hostname not in hostUser:
			hostUser[hostname] = []
		if name not in hostUser[hostname]:
			hostUser[hostname].append(name)
	if name not in allUsers:
		allUsers.append(name)

for host in hosts:
	assert(len(hostUser[host])==1)

for user in allUsers:
	print "%20s" % user, 
	usage = []
	for host in hosts:
		if user not in hostUser[host]:
			continue
		usage.append(len(hosts[host]))
	wastage = len(usage)*8 - sum(usage)
	print "E/A: %4d/%4d" % (len(usage)*8,sum(usage)),
	print "\tW: %4d/%2.1f" % (wastage, wastage/8.0)
	#print "Raw:",usage
	

