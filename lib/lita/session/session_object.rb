module Lita::Session
	class ContentModel < ::Ohm::Model
		attribute :name
		attribute :value
		
		index :name
	end
	class SessionModel < ::Ohm::Model
		attribute :sid
		set :attributes, 'Lita::Session::ContentModel'
		index :sid

		def [] key
			attributes.find(name: key).first.value
		end

		def []= key, value
			attribute = attributes.find(name: key).first
			unless attribute
				attributes.add(ContentModel.create(name:key, value: value))
			else
				attribute.update(value: value)
			end
		end

		def destroy
			attributes.map{|x| x.delete }
			delete
		end
	end

	module SessionObject

		def session sid, opts = {}
			sess = SessionModel.find(sid: sid).first
			if opts[:create]
				sess.destroy unless sess.nil?
				sess = SessionModel.create(sid: sid)
			end
			sess
		end
	end
end