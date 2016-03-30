/*
 * This class not only produces the global org.hibernate.SessionFactory reference in its static initializer;
 * it also hides the fact that it uses a static singleton
 */

package _00_Misc;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

public class HibernateUtil_H4_Ver1 {

	private static final SessionFactory sessionFactory = buildSessionFactory();

	private static SessionFactory buildSessionFactory() {
		try {
			// Create the SessionFactory from hibernate.cfg.xml
			 Configuration cfg = new Configuration().configure();
			 ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties()).build();
			 SessionFactory sessionFactory = cfg.buildSessionFactory(serviceRegistry);
			 return sessionFactory;
		} catch (Throwable ex) {
			// Make sure you log the exception, as it might be swallowed
			System.err.println("Initial SessionFactory creation failed." + ex);
			throw new ExceptionInInitializerError(ex);
		}
	}

	public static SessionFactory getSessionFactory() {
		return sessionFactory;
	}

}