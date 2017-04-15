package org.mm.servlet;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckCodeServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 //设置页面不缓存
		        response.setHeader("Pragma","No-cache");
		        response.setHeader("Cache-Control","no-cache");
		        response.setDateHeader("Expires", 0);
		         
		        // 设置图片的长宽
		        int width = 70; 
		        int height = 30;
		        //System.out.println(width + " ... " + height);
		        //int width=120, height=30;
		         
		        //备选字符集
		        String[] set = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","y","z","0","1","2","3","4","5","6","7","8","9"};
//		        String[] set = {"0","1","2","3","4","5","6","7","8","9"};
//		        String[] set = {"石","家","庄","学","院"};
		        //备选字体
		        String[] fontTypes = {"\u5b8b\u4f53","\u65b0\u5b8b\u4f53","\u9ed1\u4f53","\u6977\u4f53","\u96b6\u4e66"};
		             
		        //创建内存图像
		        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		        // 获取图形上下文
		        Graphics g = image.getGraphics();
		        // 设定图像背景色(设置为白色)
		        g.setColor(Color.WHITE);
		        g.fillRect(0, 0, width, height);
		        //创建随机类的实例
		        Random random = new Random();
		     
		        //在图片背景上增加噪点
		     
		        g.setColor(getRandColor(random,160,200));
		        g.setFont(new Font("Times New Roman",Font.PLAIN,14));
		        for (int i=0;i<6;i++)
		        {
		            g.drawString("*********************************************",0,5*(i+2));
		        }
		     
		        //生成随机数(6个字母)
		        String  sRand="";
		        int len=4;//四位
		        for (int i=0;i<len;i++)
		        {
		            int nRand = random.nextInt(set.length);
		            String subRand= set[nRand];
		            sRand += subRand;
		     
		            //设置字体的随机颜色
		            g.setColor(getRandColor(random,10,150));
		     
		            //设置随机字体及大小
		            g.setFont(new Font(fontTypes[random.nextInt(fontTypes.length)],Font.BOLD,18 + random.nextInt(6)));
		     
		            //将此字母画到图片上
		            g.drawString(subRand,17*i,random.nextInt(19)+10);
		        }
		     
		        //将认证码存入session
		        HttpSession session = request.getSession();
		        session.setAttribute("CHECK_CODE",sRand);
		        //System.out.println((String)session.getAttribute("rand"));
		        //输出图象到页面
		        g.dispose();
		        ImageIO.write(image, "JPEG", response.getOutputStream());
		        response.getOutputStream().flush();
		        response.getOutputStream().close();
		    }
		     
		    public Color getRandColor(Random random,int fc,int bc)
		    {
		        if(fc > 255) fc = 255;
		        if(bc > 255) bc = 255;
		        int r = fc + random.nextInt(bc - fc);
		        int g = fc + random.nextInt(bc - fc);
		        int b= fc + random.nextInt(bc - fc);
		        return new Color(r,g,b);
	
		    }

	}


