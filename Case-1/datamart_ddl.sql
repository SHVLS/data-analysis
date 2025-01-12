/*Создание таблицы  витрины.*/


DROP TABLE analysis.rfm_segments;

CREATE TABLE analysis.rfm_segments (
	user_id int4 NOT NULL,
	recency int4 NOT NULL,
	frequency int4 NOT NULL,
	monetary_value int4 NOT NULL,
	CONSTRAINT rfm_segments_frequency_check CHECK (((frequency >= 1) AND (frequency <= 5))),
	CONSTRAINT rfm_segments_monetary_value_check CHECK (((monetary_value >= 1) AND (monetary_value <= 5))),
	CONSTRAINT rfm_segments_pkey PRIMARY KEY (user_id),
	CONSTRAINT rfm_segments_recency_check CHECK (((recency >= 1) AND (recency <= 5))),
	CONSTRAINT rfm_segments_user_id_fkey FOREIGN KEY (user_id) REFERENCES production.users(id)
);