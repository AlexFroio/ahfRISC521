import json, re, ast
from pprint import pprint
comment = re.compile('^;')
opcode = 0b0000
Ri = 0b00000
Rj = 0b00000
newdict = dict()
with open('OpCode.json') as OpData:
	OpDict = json.load(OpData)

for i in OpDict:
	newdict[str(i)] = str(OpDict[i])
OpDict = newdict


with open('ahf4722_RISC521_v.asm') as AsmInput:
	AsmData = AsmInput.read()
	

AsmData = re.sub('[\t]', ' ', AsmData)
#AsmData = re.sub("^;", '', AsmData, flags=re.MULTILINE)

AsmLine = AsmData.split('\n')
AsmLine = filter(lambda i: not comment.search(i), AsmLine)
for i in AsmLine:
	if '.directives;' in AsmLine[i]:
		
	if i in OpDict:
		print "I found " + i
	
pprint(AsmData)
pprint(AsmLine)