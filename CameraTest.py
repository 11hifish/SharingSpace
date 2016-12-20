from picamera import PiCamera
from time import sleep
import UploadHandler
import dropbox

def main():
    camera = PiCamera()
    accessToken = '0TW88kriBOAAAAAAAAABHN8fEF3t_OrBUy8up7J3JTmHju0Cq_vXS-y5cBHVjzUo'
    dbx = dropbox.Dropbox(accessToken)

    class Struct(object): pass
    data = Struct()
    data.videosToUpload = dict()

    def recordForTime(time,clipName):
        camera.start_preview()
        camera.start_recording(clipName)
        sleep(time)
        camera.stop_recording()
        camera.stop_preview()

    def recordClip(clipName,data):
        data.videosToUpload[clipName] = 0
        time = 100
        recordForTime(time,clipName)


    def upload(name):
        MyImport.upload(dbx,name)

    def getNamWithTime(format = ".h264"):
        timeStamp = time.strftime("D:%j_H:%H_M:%M",time.localtime())
        clipName = timeStamp + format

    def runLoop(data):
        clipsToUpload = 10                             
        for i in range(clipsToUpload):
            recordClip(getNamWithTime(),data)
            for vid in data.videosToUpload:
                if(data.videosToUpload[vid]):
                    try:
                        upload(vid)
                        data.videosToUpload[vid] = 1
                    except:
                        print("error on upload")

    runLoop(data)
