package _01_Sight.model;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.imageio.ImageIO;

import _01_Sight.model.dao.SightPicDAOHibernate;

public class SightPicService {
	SightPicDAOHibernate dao = new SightPicDAOHibernate();

	public static void main(String[] args) {
	}

	public SightPicVO selectBySightId(Integer sightId) {
		SightPicVO sightPicVO = null;
		List<SightPicVO> sightPicVOs = dao.selectBySightId(sightId);
		if (!sightPicVOs.isEmpty()) {
			sightPicVO = sightPicVOs.get(0);
		}
		return sightPicVO;
	}

	public BufferedImage showMainPic(Integer sightId) {
		BufferedImage bufferedImage = null;
		InputStream inputStream = null;
		List<SightPicVO> sightPics = dao.selectBySightId(sightId);
		while (sightPics.iterator().hasNext()) {
			SightPicVO sightPicVO = sightPics.iterator().next();
			if (sightPicVO.getMainPic()) {
				byte[] img = sightPicVO.getPic();
				try {
					inputStream = new ByteArrayInputStream(img);
					bufferedImage = ImageIO.read(inputStream);
				} catch (IOException ex) {
					System.out.println(ex.getMessage());
				} finally {
					if (inputStream != null) {
						try {
							inputStream.close();
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		return bufferedImage;

		// SightVO sVO = (SightVO) pageContext.getAttribute("sightVO");
		// int sightId = sVO.getSightId();
		// SightPicService sps = new SightPicService();
		// SightPicVO spVO = sps.selectBySightId(sightId);

	}
}
