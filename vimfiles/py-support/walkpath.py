import os
import os.path
def walkDir(rootdir):
    for root,dirnames,filenames in os.walk(rootdir):
        #for dirname in  dirnames:
        #    print dirname
        #print ""
        for filename in filenames:
            print os.path.join(root,filename)
