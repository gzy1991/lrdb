package cn.org.cflac.lardb.fileUpload.util;

import java.io.IOException;

public class Ffmpeg {

    public static void main(String[] args) {

        //视频文件  
        String videoRealPath = "G://real//WA-182.avi";  
        //截图的路径（输出路径）  
        String imageRealPath ="G://a.jpg";  
        try {      
            //调用批处理文件     
            Runtime.getRuntime().exec("cmd /c start D://ffmpeg.bat " + videoRealPath + " " + imageRealPath);    
        } catch (IOException e) {     
            // TODO Auto-generated catch block      
            e.printStackTrace();      
        }
    }
}