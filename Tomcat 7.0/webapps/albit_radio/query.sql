SELECT * FROM sms.nradio_cdrs order by id desc;


select nradio_cdrs.ID, datein, DATE_FORMAT(datein, '%Y-%m-%d %H:%i:%S' ) as thedatein , readtime, shortcode, msisdn,
 readable ,  
nradio_pgms.id , 
nradio_pgms.pgm_name

from sms.nradio_cdrs 
LEFT JOIN sms.nradio_pgms
ON nradio_pgms.id=nradio_cdrs.pgmid

where datein > '20140912132024' and datein < '20140913235959'  order by nradio_cdrs.ID asc

