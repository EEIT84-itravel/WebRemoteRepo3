package _01_Sight.model;

import java.io.Serializable;
import java.util.Arrays;

public class SightPicVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer sightPicId;  //景點圖片編號
	private Integer sightId;	 //景點編號
	private boolean mainPic;	 //是否為主圖
	private byte[] pic;  		 //圖檔(型態暫定)
			
	@Override
	public String toString() {
		return "SightPicVO [sightPicId=" + sightPicId + ", sightId=" + sightId
				+ ", mainPic=" + mainPic + ", pic=" + Arrays.toString(pic)
				+ "] \n";
	}
	public Integer getSightPicId() {
		return sightPicId;
	}
	public void setSightPicId(Integer sightPicId) {
		this.sightPicId = sightPicId;
	}
	public Integer getSightId() {
		return sightId;
	}
	public void setSightId(Integer sightId) {
		this.sightId = sightId;
	}
	public boolean isMainPic() {
		return mainPic;
	}
	public void setMainPic(boolean mainPic) {
		this.mainPic = mainPic;
	}
	public byte[] getPic() {
		return pic;
	}
	public void setPic(byte[] pic) {
		this.pic = pic;
	}

}
