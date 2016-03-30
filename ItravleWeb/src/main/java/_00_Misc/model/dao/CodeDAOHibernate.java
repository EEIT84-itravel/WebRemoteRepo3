package _00_Misc.model.dao;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import _00_Misc.HibernateUtil_H4_Ver1;
import _00_Misc.model.CodeVO;

public class CodeDAOHibernate {

	public static void main(String[] args) {
		CodeDAOHibernate dao = new CodeDAOHibernate();
		// select
		// CodeVO res = dao.select("county01");
		// System.out.println(res);

		// selectAll
		// List<CodeVO> codes = dao.select();
		// for (CodeVO pb : codes) {
		// System.out.println(pb);
		// }

		// update
		// CodeVO codeVO = dao.update("testLabel01", "測試標籤2");
		// System.out.println(codeVO);

		// insert
		// CodeVO c1 = new CodeVO();
		// c1.setCodeId("testLabel01");
		// c1.setCodeName("測試標籤");
		// CodeVO code = dao.insert(c1);
		// System.out.println(code);

		// delete
		// System.out.println(dao.delete("testLabel01"));

	}

	public CodeVO insert(CodeVO codeVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(codeVO);
			session.getTransaction().commit();
			return codeVO;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return null;
		} finally {
			session.close();
		}
	}

	public CodeVO update(String codeId, String codeName) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			CodeVO codeVO = (CodeVO) session.get(CodeVO.class, codeId);
			codeVO.setCodeName(codeName);
			session.getTransaction().commit();
			return codeVO;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return null;
		} finally {
			session.close();
		}
	}

	public CodeVO select(String codeId) {
		CodeVO codeVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			codeVO = (CodeVO) session.get(CodeVO.class, codeId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return codeVO;
	}

	private static final String GET_ALL_STMT = "from CodeVO order by codeId";

	public List<CodeVO> select() {
		List<CodeVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	public boolean delete(String codeId) {
		Session session = null;
		session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Query query = session.createQuery("delete from CodeVO where codeId=?");
		query.setParameter(0, codeId);
		int delete = query.executeUpdate();
		if (delete != 0) {
			session.getTransaction().commit();
			return true;
		} else {
			session.getTransaction().rollback();
			return false;
		}
	}
}
