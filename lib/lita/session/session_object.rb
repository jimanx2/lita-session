module Lita::Session 
	class SessionModel < ::Ohm::Model
		attribute :sid
		attribute :content

		index :sid

		def [] key
			content[key]
		end

		def []= key, value
			content[key] = value
			update(content: content)
			save
		end

		def destroy
			update(content: Hash.new)
			delete
		end
	end

	module SessionObject

		def session sid
			sess = SessionModel.find(sid: sid)
			unless sess.any?
				sess = SessionModel.create(sid: sid, content: {})
			end
			sess
		end
	end
end